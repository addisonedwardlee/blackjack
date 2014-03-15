class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <button class="new-hand">New Hand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": ->
      @model.get('playerHand').hit()
      @model.checkScores()
    "click .stand-button": ->
      @model.get('dealerHand').stand()
      @model.checkScores()
    "click .new-hand": ->
      @model.newHand()

  initialize: ->
    @render()
    @model.on("win", -> $('.message').first().append('<div>HOOOORAY</div>'))
    @model.on("lose", -> $('.message').first().append('<div>OH NOOOOOO</div>'))
    @model.on("tie", -> $('.message').first().append('<div>NO MONEY NO FUNNY HONEY</div>'))
    @model.checkScores()


  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el



# when win, play Halo HOORAAYYYY
# when lose, tbd
