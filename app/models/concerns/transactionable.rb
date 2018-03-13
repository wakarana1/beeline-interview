# module Transactionable
#   extend ActiveSupport::Concern
#   included do
#     singleton_class.prepend OverriddenCount
#   end

#   module OverriddenCount
#     def scope(category)
#       where(category: category).size
#     end
#   end
# end
