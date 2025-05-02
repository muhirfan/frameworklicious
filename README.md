# Movie Recommendation System with Core ML

This project demonstrates a hybrid movie recommendation system using **Create ML’s MLRecommender** (for collaborative filtering) and a custom **content-based filtering** engine in Swift. It leverages Core ML, SwiftUI, and genre-based similarity to generate personalized movie suggestions.

---

## Collaborative Filtering

Collaborative filtering uses user–item interactions to learn latent preferences and generate recommendations.

### Data

- `ratings.csv`: Contains rows of `(userID, movieID, rating)`.

### Model

- Uses **Create ML’s `MLRecommender`**, which learns a vector for each user and movie in a shared latent space.

### Inference

For each movie \( m \), the recommender computes:

![Screenshot 2025-05-02 at 3 19 39 PM](https://github.com/user-attachments/assets/1da5e96c-abfb-432b-814f-a38bb4260226)


Where:
- \( u_{user} \): vector for the user
- \( v_m \): vector for the movie

Movies are ranked by **dot product**, returning the **top-K unseen items**.

---

## Content-Based Filtering

Content-based filtering recommends movies based on genre similarity.

### Data

- `movies.csv`: Contains rows of `(movieID, title, genres)`.

### Feature Encoding

- Builds a **one-hot vector** \( g_i \in \{0, 1\}^D \) for each movie, where each position corresponds to a genre.

### Similarity Computation

For a target movie \( g_1 \), the system computes **cosine similarity** with every other movie:

![Screenshot 2025-05-02 at 3 20 05 PM](https://github.com/user-attachments/assets/64cc0b12-5f06-47c5-80de-2003ec277d84)


Returns the **top-K most similar movies**.

---

## How the App Works

1. **On Launch**:
   - Loads `ratings.csv` and `movies.csv` from the app bundle.

2. **Collaborative Recommendations**:
   - Initializes `MovieRecommender` using `ratings.csv`.
   - Filters ratings for **User 1**.
   - Calls `prediction(items:k:restrict:exclude:)` to get top-5 suggestions.
   - Maps prediction output to movie titles.

3. **Content-Based Recommendations**:
   - Initializes `ContentBasedRecommender`.
   - Builds one-hot vectors from genres in `movies.csv`.
   - Calls `similarityScores(similarTo:topK:)` to get top-5 similar movies.

4. **UI**:
   - Displays both recommendation lists and a brief algorithm summary in a **SwiftUI List**.

---

## Documentation Links

- [Core ML Official Documentation](https://developer.apple.com/documentation/coreml)
- [Create ML Documentation](https://developer.apple.com/machine-learning/create-ml/)
- [MLRecommender API Reference](https://developer.apple.com/documentation/createml/mlrecommender)

---

## Human Interface Guidelines

- [Apple Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)

---

## WWDC Sessions

- [Training Recommendation Models in Create ML (WWDC 2019)](https://developer.apple.com/videos/play/wwdc2019/427/)
- [Control Training in Create ML with Swift (WWDC 2020)](https://developer.apple.com/videos/play/wwdc2020/10156/)
- [Build Dynamic iOS Apps with Create ML (WWDC 2021)](https://developer.apple.com/videos/play/wwdc2021/10037/)
- [What’s New in Create ML (WWDC 2024)](https://developer.apple.com/videos/play/wwdc2024/10183/)

---

## 📦 Additional Resources

- [Core ML Tools (Convert models)](https://coremltools.readme.io/)
- [Machine Learning Overview](https://developer.apple.com/machine-learning/)
- [Core ML Models Gallery](https://developer.apple.com/machine-learning/models/)



