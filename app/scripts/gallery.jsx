/* jshint camelcase: false */

'use strict';

var Photo = React.createClass({
  render: function () {
    return (
      <li>
        <a href={this.props.href}>
          <img src={this.props.thumb} width={this.props.width}
            alt={this.props.alt} />
        </a>
      </li>
    );
  }
});

var Gallery = React.createClass({
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

  getInitialState: function () {
    return {photos: []};
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

    window.addEventListener('scroll', _.throttle(this.onScroll, 300));
    window.addEventListener('resize', _.throttle(this.onResize, 300));
  },

  componentDidUpdate: function () {

    // console.log(React.findDOMNode(this.refs), React.findDOMNode(this.refs.list));

    imagesLoaded(React.findDOMNode(this.refs.list), function () {
      this.pageHeight = document.body.offsetHeight;
      this.isLoading = false;
    }.bind(this));
  },

  render: function () {
    var photoNodes = this.state.photos.map(function (photo) {
      return (
        <Photo key={photo.id} href={photo.url_l} thumb={photo.url_z} width={photo.width_z}
          height={photo.height_z} alt={photo.title} />
      );
    });

    return (
      <ol ref="list">
        {photoNodes}
      </ol>
    );
  }
});

React.render(
  <Gallery url="/photos.json" />,
  document.querySelector('.gallery')
);
