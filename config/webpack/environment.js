const { environment } = require('@rails/webpacker')

const webpack = require("webpack")

const fileLoader = environment.loaders.get('file')
fileLoader.exclude = /node_modules[\\/]quill/

const svgLoader = {
  test: /\.svg$/,
  loader: 'svg-inline-loader'
}

environment.loaders.prepend('svg', svgLoader)

environment.plugins.append("Provide", new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default']
}))

module.exports = environment
