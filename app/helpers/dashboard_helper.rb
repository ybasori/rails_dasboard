module DashboardHelper
    def list_module(role)
        Role.where(alias: role).take.modulepages
    end
    def self.access_module(role, url)
        m = Role.where(alias: role).take.modulepages.where(url: url).take
        if m 
            return true
        else
            return false
        end
    end
end
