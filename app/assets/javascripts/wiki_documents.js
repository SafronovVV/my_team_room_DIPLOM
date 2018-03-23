function editParam(editForm, content){
  let editFormHidden = $(editForm).css('display') == 'none';
  let contentHidden = $(content).css('display') == 'none';
  $(content).css({'display': (contentHidden ? '' : 'none')});
  $(editForm).css({'display': (editFormHidden ? '' : 'none')});
  let submitButtonHidden = $('#doc-title-content-edit').css('display') == 'none'
                          && $('#doc-body-content-edit').css('display') == 'none';
  $('#wiki-edit-button-submit').css({'display': (submitButtonHidden ? 'none' : '')});
}
