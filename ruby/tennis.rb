# frozen_string_literal: true

class TennisGame1
  def initialize(player1Name, player2Name)
    @player1 = Player.new(player1Name)
    @player2 = Player.new(player2Name)
    @players = { player1Name => @player1, player2Name => @player2 }
  end

  def won_point(playerName)
    @players[playerName].award_point
  end

  def score
    return tied_score_result if @player1.score == @player2.score

    return score_greater_than_4_result if (@player1.score >= 4) || (@player2.score >= 4)

    basic_score_result
  end

  def tied_score_result
    {
      0 => 'Love-All',
      1 => 'Fifteen-All',
      2 => 'Thirty-All'
    }.fetch(@player1.score, 'Deuce')
  end

  def score_greater_than_4_result
    score_difference = @player1.score - @player2.score
    return "Advantage #{@player1.name}" if score_difference == 1

    return "Advantage #{@player2.name}" if score_difference == -1

    return "Win for #{@player1.name}" if score_difference >= 2

    "Win for #{@player2.name}"
  end

  def basic_score_result
    map = {
      0 => 'Love',
      1 => 'Fifteen',
      2 => 'Thirty',
      3 => 'Forty'
    }

    "#{map[@player1.score]}-#{map[@player2.score]}"
  end
end

class TennisGame2
  def initialize(player1Name, player2Name)
    @player1 = Player.new(player1Name)
    @player2 = Player.new(player2Name)
  end

  SCORE_MAP = {
    0 => 'Love',
    1 => 'Fifteen',
    2 => 'Thirty',
    3 => 'Forty'
  }

  def won_point(player_name)
    victor = [@player1, @player2].detect { |p| p.name == player_name }
    victor.award_point
  end

  def score_tied
    if(@player1.score < 3)
      return SCORE_MAP[@player1.score] + '-All'
    end
    return 'Deuce'
  end

  def score
    result = ''
    if (@player1.score == @player2.score)
      return score_tied
    end

    if (@player1.score >= 4) && (@player2.score >= 0) && ((@player1.score - @player2.score) >= 2)
      return 'Win for ' + @player1.name
    end
    if (@player2.score >= 4) && (@player1.score >= 0) && ((@player2.score - @player1.score) >= 2)
      return 'Win for ' + @player2.name
    end

    p1res = ''
    p2res = ''
    if (@player1.score > 0) && (@player2.score == 0)
      return SCORE_MAP[@player1.score] + '-' + SCORE_MAP[@player2.score]
    end

    if (@player2.score > 0) && (@player1.score == 0)
      return SCORE_MAP[@player1.score] + '-' + SCORE_MAP[@player2.score]
    end

    if (@player1.score > @player2.score) && (@player1.score < 4)
      return SCORE_MAP[@player1.score] + '-' + SCORE_MAP[@player2.score]
    end
    if (@player2.score > @player1.score) && (@player2.score < 4)
      return SCORE_MAP[@player1.score] + '-' + SCORE_MAP[@player2.score]
    end
    if (@player1.score > @player2.score) && (@player2.score >= 3)
      result = 'Advantage ' + @player1.name
    end
    if (@player2.score > @player1.score) && (@player1.score >= 3)
      result = 'Advantage ' + @player2.name
    end

    result
  end
end

class TennisGame3
  def initialize(player1Name, player2Name)
    @p1N = player1Name
    @p2N = player2Name
    @p1 = 0
    @p2 = 0
  end

  def won_point(n)
    if n == @p1N
      @p1 += 1
    else
      @p2 += 1
    end
  end

  def score
    if ((@p1 < 4) && (@p2 < 4)) && (@p1 + @p2 < 6)
      p = %w[Love Fifteen Thirty Forty]
      s = p[@p1]
      @p1 == @p2 ? s + '-All' : s + '-' + p[@p2]
    else
      if @p1 == @p2
        'Deuce'
      else
        s = @p1 > @p2 ? @p1N : @p2N
        (@p1 - @p2) * (@p1 - @p2) == 1 ? 'Advantage ' + s : 'Win for ' + s
      end
    end
  end
end

class Player
  attr_accessor :name, :score

  def initialize(name)
    @name = name
    @score = 0
  end

  def award_point
    @score += 1
  end
end
