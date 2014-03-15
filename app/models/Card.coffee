class window.Card extends Backbone.Model

  initialize: (params) ->
    @set
      revealed: true
      value: if !params.rank or 10 < params.rank then 10 else params.rank
      suitName: ['Spades', 'Diamonds', 'Clubs', 'Hearts'][params.suit]
      rankName: switch params.rank
        when 0 then 'K'
        when 1 then 'A'
        when 11 then 'J'
        when 12 then 'Q'
        else params.rank

  flip: ->
    @set 'revealed', !@get 'revealed'
    @
