var Publish = React.createClass({
  getInitialState() {
    return {
      offer: this.props.offer
    };
  },
  render: function() {
    var published = this.state.offer.published
    var divClasses = classNames({
      "badge": true,
      "small-badge": true,
      "small-badge-off": !published
    })
    return (
      <div>
        <div className="form-group montserrat">
          <select value={published} className="form-control offer_published" onChange={this.handleChange}>
            <option value={false}>{this.props.offer.i18n_hidden}</option>
            <option value={true}>{this.props.offer.i18n_published}</option>
          </select>
        </div>
        <div className="text-center">
          <span className={divClasses}> </span>
        </div>
      </div>
    )
  },
  handleChange: function() {
    var that = this
    $.ajax({
      type: 'PUT',
      url: Routes.publish_offer_path(this.props.offer.id, {format: 'json'}),
      success: function(data) {
        that.setState({ offer: data })
      }
    })
  }
})