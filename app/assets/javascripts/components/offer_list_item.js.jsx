var OverlayTrigger = ReactBootstrap.OverlayTrigger
var Popover = ReactBootstrap.Popover

var OfferListItem = React.createClass({
  render: function() {
    var position = this.props.reactKey > 2 ? "top" : "bottom"
    var style = {
      backgroundImage: 'url(' + this.props.offer.pictureUrl + ')'
    }
    return (
      <div className="col-xs-6 col-sm-4">
        <div className="card">
          <span className="card-bg" style={style}></span>
          <span className="card-shadow"></span>
          <span className="card-description">
            {this.props.offer.price}
          </span>
          <span className="card-text">
            <h2>{this.props.offer.nature}</h2>
          </span>
          <span className="card-user">
            <img src={this.props.offer.icon} />
          </span>
          <OverlayTrigger trigger="click" rootClose placement={position} overlay={
            <Popover id={'popover_' + this.props.offer.id}>
              <PopoverContent offer={this.props.offer} />
            </Popover>
          }>
            <div className="card-link" id={'myOffer_' + this.props.offer.id} data-href={this.props.offer.offer_path}>
            </div>
          </OverlayTrigger>
        </div>
      </div>
    )
  }
})