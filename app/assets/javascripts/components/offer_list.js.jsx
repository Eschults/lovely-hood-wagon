var OfferList = React.createClass({
  render: function() {
    return (
      <div className="panel-body padding-none border-top-221">
        {this.props.offers.map(function(offer, index) {
          return <OfferListItem offer={offer} key={index} />
        })}
      </div>
    )
  }
})