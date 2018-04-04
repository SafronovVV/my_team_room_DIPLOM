class RequestService {
  constructor (url, parameters = {}){
    this.url = url;
    this.parameters = parameters;
  }

  post(successResponder, errorResponder = null){
    $.ajax({
      type: 'POST',
      data: this.parameters,
      url: this.url,
      success: successResponder,
      error: errorResponder
    })
  }
}
