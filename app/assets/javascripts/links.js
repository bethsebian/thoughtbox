$(document).ready(function() {
  listAllIdeas();
});

function listAllIdeas() {
  var target = $('#links-list');
  return $.getJSON('api/v1/links.json').then(function (links) {
    collectAndFormatLinks(links, target);
  });
}

function collectAndFormatLinks(links, target) {
  var renderedLinks = links.map(renderLink);
  $(target).append(renderedLinks);
}

function renderLink(link) {
  return $(
    '<div class="link_info" id="link_'
    + link.id
    + '" ><br>Url: '
    + link.url
    + '<br>Title: '
    + link.title
    + '<br>Read: '
    + link.read_status
    + '<br><br></div>'
  );
}