class Book < ActiveRecord::Base
  include ActiveModel::Transitions
  belongs_to :category

  state_machine attribute_name: :status do
    state :avaliable
    state :reserved

    event :reserve do
      transitions to: :reserved, from: [:avaliable]
    end

    event :unreserve do
      transitions to: :avaliable, from: [:reserved]
    end
  end

  def self.text_search(query)

    if query.present?
      rank = <<-RANK
        ts_rank(to_tsvector(title), plainto_tsquery(#{sanitize(query)})) +
        ts_rank(to_tsvector(description), plainto_tsquery(#{sanitize(query)}))
      RANK
      where("title @@ :q or description @@ :q", q: query).order("#{rank} desc")
    else
      scoped
    end
  end
end
