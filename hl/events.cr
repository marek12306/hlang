module HL::Events
    @handlers = [] of Tuple(String, Proc(String, Nil))

    def on(name : String, handler : Proc(String, Nil))
        @handlers << {name, handler}
        nil
    end

    def invoke(name : String, data : String)
        @handlers.select { |h| h[0] == name }.each do |h|
            h[1].call data
        end
    end
end
