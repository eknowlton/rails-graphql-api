class SyncAbilities
  def initialize(permissable, new_abilities = [])
    @permissable = permissable
    @new_abilities = new_abilities
  end

  def call
    create_new_abilities
    delete_old_abilities

    if permissable.valid?
      Result.success(permissable: permissable.reload)
    else
      Result.failure(errors: permissable.errors)
    end
  end

  private

  attr_reader :permissable, :new_abilities

  def create_new_abilities
    permissable.permissions << new_abilities
      .reject { |ability| permissable.abilities.include?(ability) }
      .map { |ability|
      Permission.new(permissable: permissable, ability: ability)
    }
  end

  def delete_old_abilities
    permissable
      .permissions
      .select { |permission| new_abilities.exclude?(permission.ability) }
      .each(&:delete)
  end
end
