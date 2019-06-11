module DashboardHelper
    def list_module(role)
        Role.where(alias: role).take.modulepages
    end
end
