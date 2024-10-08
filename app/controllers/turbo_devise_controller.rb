class TurboDeviseController < ApplicationController
    class Responder < ActionController::Responder
        def to_chatly_stream
            controller.render(options.merge(formats: :html))
        rescue ActionView::MissingTemplate => e
            if get?
                raise e
            elsif has_errors? && default_action
                render rendering_options.merge(formats: :html, status: :unprocessable_entity)
            else
                redirect_to navigation_location
            end
        end
    end

    self.responder = Responder
    respond_to :html, :chatly_stream
end