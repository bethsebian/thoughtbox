$(document).ready(function() {
  listAllLinks();
  readLink();
  unreadLink();
});

function listAllLinks() {
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
    + '<br>Read: <div id="status_'
    + link.id
    + '" >'
    + link.read_status
    + '</div><br><br><div id="status_button_'
    + link.id
    + '" >'
    + (link.read_status === true ? ('<button class="mark_unread" id=' + link.id + ' name="mark_unread">Mark Unread</button>') : ('<button class="mark_read" id=' + link.id + ' name="mark_read">Mark Read</button>'))
    + '</div>'
  );
}

function readLink(link) {
  $("#links-list").delegate(".mark_read", 'click', function() {
    var link_id = this.id;
    var change_type = { "change_type": true };

    putJSON(link_id, change_type);
  });
}

function unreadLink(link) {
  $("#links-list").delegate(".mark_unread", 'click', function() {
    var link_id = this.id;
    var change_type = { "change_type": false };

    putJSON(link_id, change_type);
  });
}

function putJSON(link_id, change_type) {
  $.ajax({
    type: "put",
    url: "/api/v1/links/" + link_id + ".json",
    data: change_type,
    success: function(link) {
      updateLinkInIndex(link);
    },
    error: function(xhr) {
      console.log(xhr.responseText);
    }
  });
}

function updateLinkInIndex(link) {
  var url = "/api/v1/links/" + link.id + ".json";
  $.ajax({
    type: "get",
    dataType: "json",
    url: url,
    success: function(link) {
      updateStatus(link);
    }
  });
}

function updateStatus(link) {
  $('#status_' + link.id).text(link.read_status);
  if(link.read_status === true) {
    $('#status_button_' + link.id).append('<button class="mark_unread" id=' + link.id + ' name="mark_unread">Mark Unread</button>');
    $('#status_button_' + link.id).remove('<button class="mark_read" id=' + link.id + ' name="mark_read">Mark Read</button>');
  } else {
    $('#status_button_' + link.id).append('<button class="mark_read" id=' + link.id + ' name="mark_read">Mark Read</button>');
    $('#status_button_' + link.id).remove('<button class="mark_unread" id=' + link.id + ' name="mark_unread">Mark Unread</button>');
  }
}

