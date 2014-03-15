#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

  checkScores: ->
    playerScore = @get('playerHand').bestScore()
    dealerScore = @get('dealerHand').bestScore()

    #simple win/lose situations
    if dealerScore > 21 then @trigger('win', @)
    if playerScore > 21 then @trigger('lose', @)

    #blackjacks
    if playerScore is 21 and @get('playerHand').length is 2 then @trigger('win', @)
    if dealerScore is 21 and @get('dealerHand').length is 2 then @trigger('lose', @)

    #after stand
    if @get('dealerHand').first().get('revealed')
      #tieing conditions
      if dealerScore is playerScore then @trigger('tie', @)
      #other conditions
      else if 16 < dealerScore < 22
        if playerScore > dealerScore then @trigger('win', @) else @trigger('lose', @)
      else if dealerScore < 22
        @get('dealerHand').hit()
        @checkScores()

  newHand: ->
    $('.games').empty()
    $('.message').empty()
    new AppView(model: new App()).$el.appendTo '.games'

#check blackjack function
#fix tieing conditions
