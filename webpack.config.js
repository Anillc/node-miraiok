const webpack = require ('webpack');

module.exports = {
  //mode: 'production',
  mode: 'development',
  target: 'node',
  entry: './src/index.coffee',
  module: {
    rules: [
      {
        test: /\.coffee$/,
        loader: 'coffee-loader'
      }
    ]
  },
  plugins: [
    new webpack.BannerPlugin({
      banner: "#!/usr/bin/env node", raw: true 
    })
  ]
};
