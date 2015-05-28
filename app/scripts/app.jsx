import React    from 'react';

import Gallery  from './components/gallery';

import './fonts';

var gallery = document.querySelector('.gallery');

if (gallery) {
  React.render(
    <Gallery />,
    gallery
  );
}
