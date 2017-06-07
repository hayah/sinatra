class Idea
  include Comparable
  attr_reader :title, :description, :rank, :id, :tags

  def initialize(attributes = {})
    @title = attributes['title']
    @description = attributes['description']
    @rank = attributes['rank'].to_i || 0
    @id = attributes['id']
    @tags = attributes['tags']
  end

  def save
    IdeaStore.create(to_h)
  end

  def to_h
    {
      'title'=> title,
      'description'=> description,
      'rank' => rank,
      'tags' => tags
    }
  end

  def database
    Idea.database
  end

  def like!
    @rank += 1
  end

  def <=>(other)
    other.rank <=> rank
  end
end
