module NotesHelper
  def current_notes
    current_user.notes.scoped
  end
end
