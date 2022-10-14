



class Event

    attr_accessor :name; 
    attr_accessor :addr; 

    def initialize(_name, _addrArr = [])
        @name = _name;
        @addr = _addrArr;
    end

    def addAddr(func)
        @addr[@addr.length()] = func;
    end

    def callAddr(arg=0)
        @addr.each {|event| 
            event.call(arg);
        }
    end
end


$eventsSDK = nil; 

def addEvent(name, func);
    if $eventsSDK != nil
        $eventsSDK.each {|event| 
            if event.name == name
                msgbox name + " Hey wtf man"
                event.addAddr(func);
                return;
            end
        }

        nClass = Event.new(name, [func]);
        $eventsSDK[$eventsSDK.length()] = nClass;
    else
        nClass = Event.new(name, [func]);
        $eventsSDK = [nClass];
    end
end

def callEvent(name, arg=0);
    $eventsSDK.each {|event| 
        if event.name == name
            event.callAddr(arg);
            return;
        end
    }
end



#EXEMPLE
=begin
def SomeDocTest(arg)
    msgbox arg
end
EventSDK.addEvent("OnInit", method(:SomeDocTest));
EventSDK.callEvent("OnInit", "me");
=end
