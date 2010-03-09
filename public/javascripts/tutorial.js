foldable = function($) {
  $(document).ready(function() {
    $('.fold').hide();
    $('.handle').click(function() {
      var section_id = '#' + $(this).attr('id') + '-fold';
      $(section_id).toggle();
    }).css('cursor', 'pointer');
  });
} (adaptiveProxyJQuery);
