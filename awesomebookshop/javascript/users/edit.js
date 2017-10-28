$(document).ready(function() {
  removeGenderLabel();
});

function removeGenderLabel() {
  $('.row-gender-edit').parent().attr('id', 'label-gender');
}