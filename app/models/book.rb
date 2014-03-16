class Book < ActiveRecord::Base

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
