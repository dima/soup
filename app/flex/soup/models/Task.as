package soup.models {
  import org.restfulx.models.RxModel;
  
  [Resource(name="tasks")]
  [Bindable]
  public class Task extends RxModel {
    public static const LABEL:String = "name";

    public var name:String = "";

    public var notes:String = "";

    [BelongsTo]
    public var project:Project;

    public function Task() {
      super(LABEL);
    }
  }
}
