/* jshint camelcase: false */

(function() {
  'use strict';

  var container = document.querySelector('.page-gallery .main');
  var user = '66667715@N07';
  var photos = document.createElement('ol');
  var photosFrag = document.createDocumentFragment();

  var pageHeight = document.body.offsetHeight;
  var viewHeight = window.innerHeight;
  var overlap = 500;

  var page = 1;

  var flickr = new Flickr({
    api_key: '1e7490875accc5b9c1ca91a2f27b5604'
  });

  var isLoading = false;

  var loadNext = function () {
    isLoading = true;

    flickr.people.getPhotos({
      user_id: user,
      content_type: 1,
      extras: 'url_z,url_l',
      per_page: 10,
      page: page
    }, function (err, result) {
      _.each(result.photos.photo, function (photo) {
        var li = document.createElement('li');
        var a = document.createElement('a');
        var img = document.createElement('img');

        img.src = photo.url_z;
        img.width = photo.width_z;
        img.height = photo.height_z;
        img.alt = photo.title;
        img.style.opacity = '0';
        img.onload = function () {
          this.style.opacity = '1';
        };

        a.href = photo.url_l;

        a.appendChild(img);
        li.appendChild(a);
        photosFrag.appendChild(li);
      });

      photos.appendChild(photosFrag);

      imagesLoaded(photos, function () {
        // update cached page height
        pageHeight = document.body.offsetHeight;
        isLoading = false;
      });

      page++;
    });
  };

  // infinite scroll
  window.addEventListener('scroll', _.throttle(function () {
    var limit = pageHeight - viewHeight - overlap;

    if (document.body.scrollTop >= limit && !isLoading) {
      loadNext();
    }
  }, 300));

  // update cached viewport height
  window.addEventListener('resize', _.throttle(function () {
    viewHeight = window.innerHeight;
  }, 300));

  container.innerHTML = '';
  container.appendChild(photos);

  // initial load
  loadNext();

}());
