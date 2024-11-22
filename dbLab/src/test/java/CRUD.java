import org.hibernate.Session;
import org.hibernate.SessionFactory;

import java.util.List;

public class CRUD<T> {
    private final SessionFactory factory = DBConnection.getFactory();
    private final Class<T> entity;

    public CRUD(Class<T> entity)
    {
        this.entity = entity;
    }

    public void create(T entity)
    {
        try (Session session = factory.openSession())
        {
            session.beginTransaction();
            session.persist(entity);
            session.getTransaction().commit();
        }
    }

    public T read(Long id)
    {
        try (Session session = factory.openSession())
        {
            return session.get(this.entity, id);
        }
    }

    public T read(String name)
    {
        try (Session session = factory.openSession())
        {
            return session.get(this.entity, name);
        }
    }

    public List<T> readQuery(String hql)
    {
        try (Session session = factory.openSession())
        {
            var query = session.createQuery(hql, this.entity);
            return query.getResultList();
        }
    }


    public List<T> read(String firstName, String lastName)
    {
        try (Session session = factory.openSession())
        {
            return session.createQuery(
                            "FROM " + this.entity.getName() +
                                    " WHERE firstName = :firstName AND lastName = :lastName", this.entity)
                    .setParameter("firstName", firstName)
                    .setParameter("lastName", lastName)
                    .getResultList();
        }
    }

    public List<T> read()
    {
        try (Session session = factory.openSession())
        {
            return session.createQuery("FROM " + this.entity.getName(), this.entity).list();
        }
    }

    public void update(T entity)
    {
        try (Session session = factory.openSession())
        {
            session.beginTransaction();
            session.merge(entity);
            session.getTransaction().commit();
        }
    }

    public void delete(Long id) {
        try (Session session = factory.openSession())
        {
            session.beginTransaction();
            T _entity = session.get(this.entity, id);
            if (_entity != null) {
                session.remove(_entity);
            }
            session.getTransaction().commit();
        }
    }
}