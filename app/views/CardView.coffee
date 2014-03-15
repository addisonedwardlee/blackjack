class window.CardView extends Backbone.View

  className: 'card'

  template: _.template '<%= rankName %>'

  initialize: ->
    @model.on 'change', => @render
    @render()

  render: ->
    @$el.children().detach().end().html
    @$el.html @template @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'
    @$el.addClass @model.get 'suitName', @model.get 'rankName'
