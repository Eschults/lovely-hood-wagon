var PopoverContent = React.createClass({
  render: function() {
    var style = {
      backgroundImage: 'url(' + this.props.offer.pictureUrl + ')'
    }
    return(
      <div className="popover-react">
        <a href={this.props.offer.offer_path}>
          <div className="popover-header" style={style}>
            <img src={this.props.offer.icon_path} />
          </div>
        </a>
        <p>
          {this.props.offer.description}
        </p>
        <a href={this.props.offer.edit_offer_path}>{this.props.offer.edit}</a>
        <Publish offer={this.props.offer} />
      </div>
    )
  }
})