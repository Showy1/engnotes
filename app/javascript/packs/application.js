require('@rails/ujs').start();
require('@rails/activestorage').start();
require('channels');
import 'jquery';
import 'bootstrap';
import '@fortawesome/fontawesome-free/js/all';
import '../src/application.scss';
const images = require.context('../images/', true); // eslint-disable-line

$(function(){
  setTimeout(function(){
    $('.flash').fadeOut(1000);
  }, 5000);
});
