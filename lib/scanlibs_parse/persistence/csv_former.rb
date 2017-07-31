module ScanlibsParse
  module Persistence
    module CSV
      # Base repository for CSV
      # TODO implement logic/re-architect solution
      class BaseRepository
        class << self
          def all
            raise 'Not yet implemented'
          end

          def find id
            raise 'Not yet implemented'
          end

          def findBy **params
            raise 'Not yet implemented'
          end

          def new_entity **params
            raise 'Not yet implemented'
          end

          def save object
            raise 'Not yet implemented'
          end

          def delete object
            raise 'Not yet implemented'
          end
        end
      end
    end
  end
end