class CreateSwiftypeDocumentJob < Struct.new(:post_id)
  def perform
    post = Post.find(post_id)
    url = Rails.application.routes.url_helpers.post_url(post)
    engine = Swiftype::Engine.find(ENV['SWIFTYPE_ENGINE_SLUG'])
    type = engine.document_type(Post.model_name.downcase)
    type.create_document({:external_id => post.id,
                           :fields => [{:name => 'title', :value => post.title, :type => 'string'},
                                       {:name => 'body', :value => post.body, :type => 'text'},
                                       {:name => 'url', :value => url, :type => 'enum'},
                                       {:name => 'created_at', :value => post.created_at.iso8601, :type => 'date'}]})
  end
end
