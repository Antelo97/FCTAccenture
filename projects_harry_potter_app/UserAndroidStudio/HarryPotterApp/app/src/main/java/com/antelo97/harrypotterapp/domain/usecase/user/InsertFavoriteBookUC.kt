import com.antelo97.harrypotterapp.data.repository.UserRepository
import com.antelo97.harrypotterapp.domain.model.User
import javax.inject.Inject

class InsertFavoriteBookUC @Inject constructor(private val repository: UserRepository) {

    suspend operator fun invoke(idApiBook: Int) {
        repository.insertFavBook(User.getUidAppUser(), idApiBook)
    }
}