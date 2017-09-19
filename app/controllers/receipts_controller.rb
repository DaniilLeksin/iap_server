class ReceiptsController < ApplicationController
  def validate_itunes
    Itunes.shared_secret = params['shared_secret']
    receipt = Itunes::Receipt.verify! params[:receipt_data], :allow_sandbox
    render json: { status: 'ok', receipt: receipt }
  rescue StandardError => e
    render json: { status: 'error', message: e.message }, status: 400
  end

  def validate_venice
    opts = {
      shared_secret: params['shared_secret']
    }
    receipt = Venice::Receipt.verify!(params['receipt_data'], opts)
    render json: { status: 'ok', receipt: receipt }
  rescue StandardError => e
    render json: { status: 'error', message: e.message }, status: 400
  end
end
