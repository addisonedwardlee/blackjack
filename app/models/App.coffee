#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

  checkScores: ->
    playerScore = @get('playerHand').scores()
    dealerScore = @get('dealerHand').scores()
    #simple win/lose situations
    if dealerScore[0] > 21
      @trigger('win', @)
    else if playerScore[0] > 21
      @trigger('lose', @)
    #player blackjack
    else if playerScore[1] is 21 and @get('playerHand').length is 2
        @trigger('win', @)
    #dealer blackjack
    else if dealerScore[1] is 21 and @get('dealerHand').length is 2
        @trigger('lose', @)

    #dealer flips card
    if @get('dealerHand').first().get('revealed')
      if 16 < dealerScore[1] < 22
        if playerScore[1] or playerScore[0] > dealerScore[1]
          @trigger('win', @)
        else
          @trigger('lose', @)
      else if 16 < dealerScore[0] < 22
        if playerScore[1] or playerScore[0] > dealerScore[0]
          @trigger('win', @)
        else
          @trigger('lose', @)
      else if dealerScore[0] < 22
        @get('dealerHand').hit()
        @checkScores()

    #tieing conditions
    if (dealerScore[0] or dealerScore[1]) is playerScore[1]
      @trigger('tie', @)
    if (dealerScore[0] or dealerScore[1]) is playerScore[0]
      @trigger('tie', @)

  newHand: ->
    $('.games').empty()
    $('.message').empty()
    new AppView(model: new App()).$el.appendTo '.games'
