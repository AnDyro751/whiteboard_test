module ButtonClassHelper
  def color_button(more_class = nil)
    "bg-indigo-800 text-white px-8 py-3 rounded h-12 cursor-pointer hover:bg-indigo-700 transition duration-150 hover:shadow #{more_class}"
  end
end