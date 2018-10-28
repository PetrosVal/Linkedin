package entities.AppEntities;


import java.util.Comparator;

public class RecommendedItem implements Comparator<RecommendedItem>{

    private Integer id;
    private Integer rank;

    public RecommendedItem(Integer id, Integer rank) {
        this.id = id;
        this.rank = rank;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getRank() {
        return rank;
    }

    public void setRank(Integer rank) {
        this.rank = rank;
    }

    public static final Comparator<RecommendedItem> DESC_COMPARATOR = new Comparator<RecommendedItem>() {
        public int compare(RecommendedItem o1, RecommendedItem o2) {
            return o2.getRank() - o1.getRank();
        }
    };

    @Override
    public int compare(RecommendedItem o1, RecommendedItem o2) {
        return o2.getRank() - o1.getRank();
    }
}
