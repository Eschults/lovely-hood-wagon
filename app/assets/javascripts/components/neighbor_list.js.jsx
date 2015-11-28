var NeighborList = React.createClass({
  render: function() {
    return (
      <div className="panel-body padding-none border-top-221">
        {this.props.neighbors.map(function(neighbor, index) {
          return <NeighborListItem neighbor={neighbor} key={index} />
        })}
      </div>
    )
  }
})