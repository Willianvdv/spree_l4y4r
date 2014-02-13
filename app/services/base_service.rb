class BaseService

  private 

  def client
    @_client ||= LayerClient.new
  end
end