module CloudFilesTransfer
  class AssetTransferWorker
    include Sidekiq::Worker

    def perform(container_from, container_to, path)
      object = container_from.object(path)
      container_to.transfer(object)
    end

  end
end