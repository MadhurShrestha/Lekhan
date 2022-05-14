import { DirectUpload } from "@rails/activestorage"
import ImageResize from "@taoqf/quill-image-resize-module/image-resize.min"
import Quill from 'quill/quill'
import 'quill/dist/quill.snow.css'
import "../stylesheets/quill.snow-override.scss"
export default Quill;

Quill.register('modules/imageResize', ImageResize);


document.addEventListener('turbolinks:load', function (event) {
  var quill = new Quill('#editor-container', {
    modules: {
    },
    placeholder: "What's on your mind",
    theme: 'snow'
  });

  document.querySelector('form').onsubmit = function () {
    var body = document.querySelector('input[class=article-content]');
    body.value = quill.root.innerHTML
  };
});
