/* global Flickr */

import React        from 'react';

import imagesLoaded from 'imagesloaded';
import objectFit    from 'object-fit';
import td           from 'throttle-debounce';

import Photo        from './photo';

import 'flickrapi';

export default React.createClass({
  getInitialState: function () {
    return {photos: []};
  },

  loadNext: function () {
    this.isLoading = true;

    this.flickr.people.getPhotos({
      user_id: this.user,
      content_type: 1,
      extras: 'url_z,url_l',
      per_page: 10,
      page: this.page
    }, function (err, result) {
      if (err) { throw new Error(err); }

      this.setState({photos: this.state.photos.concat(result.photos.photo)});
      this.page++;
    }.bind(this));
  },

  onScroll: function () {
    var limit = this.pageHeight - this.viewportHeight - this.overlap;

    if (document.body.scrollTop >= limit && !this.isLoading) {
      this.loadNext();
    }
  },

  onResize: function() {
    this.viewportHeight = window.innerHeight;
  },

  componentDidMount: function () {
    this.user           = '66667715@N07';
    this.pageHeight     = document.body.offsetHeight;
    this.viewportHeight = window.innerHeight;
    this.overlap        = 500;
    this.page           = 1;
    this.isLoading      = false;
    this.flickr         = new Flickr({api_key: '1e7490875accc5b9c1ca91a2f27b5604'});

    this.loadNext();

    window.addEventListener('scroll', td.throttle(300, this.onScroll));
    window.addEventListener('resize', td.throttle(300, this.onResize));
  },

  componentDidUpdate: function () {
    imagesLoaded(React.findDOMNode(this.refs.list), () => {
      this.pageHeight = document.body.offsetHeight;
      this.isLoading = false;

      objectFit.polyfill({
        selector: '.gallery img',
        fittype: 'cover'
      });
    });
  },

  render: function () {
    return (
      <ol ref="list">
        {this.state.photos.map(function (photo) {
          return (
            <Photo key={photo.id} href={photo.url_l} thumb={photo.url_z} width={photo.width_z}
              height={photo.height_z} alt={photo.title} />
          );
        })}
      </ol>
    );
  }
});
