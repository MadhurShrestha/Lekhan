import { DirectUpload } from "@rails/activestorage"
import ImageResize from "@taoqf/quill-image-resize-module/image-resize.min"
import Quill from 'quill/quill'
import 'quill/dist/quill.snow.css'
export default Quill;

Quill.register('modules/imageResize', ImageResize);

document.addEventListener('turbolinks:load', function (event) {
  var quill = new Quill('#editor-container', {
    modules: {
      imageResize: {},
      toolbar: [
        [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
        ['bold', 'italic', 'underline', 'strike'],        // toggled buttons
        [{ 'align': [] }],
        [{ 'list': 'ordered'}, { 'list': 'bullet' }],
        [{ 'script': 'sub'}, { 'script': 'super' }],      // superscript/subscript
        [{ 'indent': '-1'}, { 'indent': '+1' }],          // outdent/indent
        [{ 'direction': 'rtl' }],                         // text direction
        [{ 'size': ['small', false, 'large', 'huge'] }],  // custom dropdown
        [{ 'color': [] }, { 'background': [] }],          // dropdown with defaults from theme
        [{ 'font': [] }],
        ['blockquote', 'image'],

        ['clean']                                         // remove formatting button
      ]
    },
    placeholder: "What's on your mind",
    theme: 'snow'
  });
  document.querySelector('#page-content-form').onsubmit = function () {
    var body = document.querySelector('input[class=page-content]');
    body.value = quill.root.innerHTML
  };
});
