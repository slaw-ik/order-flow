# frozen_string_literal: true

module Utils
  def compare_arrays(array1, array2)
    new_elements = array2 - array1
    existed_elements = array1 & array2
    deleted_elements = array1 - array2

    {
      new: new_elements,
      existed: existed_elements,
      deleted: deleted_elements
    }
  end
end
