const { environment } = require('@rails/webpacker');
const { VueLoaderPlugin } = require('vue-loader');
const vue = require('./loaders/vue');
const eslint =  require('./loaders/eslint');
const webpack = require('webpack');

environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin());
environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    jquery: 'jquery',
    Popper: 'popper.js/dist/popper'
  })
);
environment.loaders.prepend('vue', vue);
environment.loaders.append('eslint', eslint);
module.exports = environment;
