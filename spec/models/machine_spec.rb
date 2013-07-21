require 'spec_helper'

describe Machine do
  subject(:valid_machine) do
    Machine.new(
      name: "test machine",
      category: "3d Printer",
      user_id: 1,
      description: "#{"test " * 99}"
    )
  end
  it { should belong_to(:user) }
  it { should have_many(:locations) }
end
