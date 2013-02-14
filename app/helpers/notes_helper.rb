module NotesHelper
  def current_notes
    current_user.notes.scoped
  end
  def to_json(notes)
    notes.to_json(:methods => [:tag_list])
  end
end
