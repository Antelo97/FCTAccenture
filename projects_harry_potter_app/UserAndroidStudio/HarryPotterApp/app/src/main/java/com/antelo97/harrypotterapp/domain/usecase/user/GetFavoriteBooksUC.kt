import com.antelo97.harrypotterapp.data.repository.UserRepository
import com.antelo97.harrypotterapp.domain.model.Book
import com.antelo97.harrypotterapp.domain.model.User
import javax.inject.Inject

class GetFavoriteBooksUC @Inject constructor(private val repository: UserRepository) {
    suspend operator fun invoke(): List<Book> {
        return repository.getFavoriteBooks(User.getUidAppUser())
        // return repository.getFavoriteBooks(FirebaseAuth.getInstance().currentUser!!.uid)
    }
}