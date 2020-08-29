module HL::Events
    @handlers = [] of Tuple(String, Proc(String, Nil))

    def on(name : String, handler : Proc(String, Nil))
        @handlers << {name, handler}
        nil
    end

    def invoke(name : String, data : String)
        handlers = @handlers.select { |h| h[0] == name }
        i = 0
        while i < handlers.size
            handlers[i][1].call data
        end
    end
end
