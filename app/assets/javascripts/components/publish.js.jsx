var Publish = React.createClass({
  render: function() {
    return (
      <div>
        <div className="form-group montserrat">
          <select value={this.props.offer.published} className="form-control offer_published" onChange={this.handleChange}>
            <option value={false}>{this.props.offer.i18n_hidden}</option>
            <option value={true}>{this.props.offer.i18n_published}</option>
          </select>
        </div>
      </div>
    )
  },
  handleChange: function() {
    this.props.onPublish()
  }
})