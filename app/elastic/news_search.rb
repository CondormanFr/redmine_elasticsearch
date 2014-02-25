module NewsSearch
  extend ActiveSupport::Concern

  module ClassMethods

    def index_mappings
      {
          news: {
              _parent: { type: 'parent_project' },
              _routing: { required: true, path: 'route_key' },
              properties: news_mappings_hash
          }
      }
    end

    def news_mappings_hash
      {
          id: { type: 'integer' },
          project_id: { type: 'integer', index: 'not_analyzed' },
          title: { type: 'string' },
          summary: { type: 'string' },
          description: { type: 'string' },
          author: { type: 'string' },
          created_on: { type: 'date' },
          comments_count: { type: 'integer', index: 'not_analyzed' },
          route_key: { type: 'string', not_analyzed: true }
      }.merge(additional_index_mappings)
    end

  end
end