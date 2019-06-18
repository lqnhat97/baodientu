$(document).ready(() => {
    var quill = new Quill('#editor', {
        theme: 'snow'
    });

    $('#uploadForm').submit((e) => {
        $("<input />").attr("type", "hidden")
          .attr("name", "noiDung")
          .attr("value", quill.root.innerHTML)
          .appendTo("#uploadForm");
        alert("ok");
        return true;
    })

    $('#uploadFormEdit').submit((e) => {
        $("<input />").attr("type", "hidden")
          .attr("name", "noiDung")
          .attr("value", quill.root.innerHTML)
          .appendTo("#uploadForm");
        alert("ok");
        return true;
    })
})